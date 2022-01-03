package com;

import com.model.ExpectedLogEntry;
import com.model.GelfLogObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.FileUtils;
import org.junit.Assert;
import org.junit.platform.commons.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class LogsVerifier {
    public static final String TIMESTAMP1REGEX = "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3}(Z|\\+\\d{2}:\\d{2})";
    public static final String TIMESTAMP2REGEX = "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}";
    public static final String ALPHANUM16REGEX = "\\w{16}";
    public static final String NUM1REGEX = "\\d{4}";
    private static final Logger LOGGER = LoggerFactory.getLogger(LogsVerifier.class);
    private final KubectlInterface kubectlInterface;
    private final ObjectMapper objectMapper;

    @Autowired
    public LogsVerifier(KubectlInterface kubectlInterface, ObjectMapper objectMapper) {
        this.kubectlInterface = kubectlInterface;
        this.objectMapper = objectMapper;
    }


    private static List<ExpectedLogEntry> extractExpectedLogs(String expectedLogsPath) throws IOException {
        return Stream.of(FileUtils.readFileToString(new File(expectedLogsPath), StandardCharsets.UTF_8).split("\\r?\\n"))
                .map(ExpectedLogEntry::of)
                .collect(Collectors.toList());
    }

    private GelfLogObject readLogObject(String line) {

        try {
            if (line.startsWith("}")) {
                line = line.substring(1);
            }
            return objectMapper.readValue(line, GelfLogObject.class);
        } catch (IOException e) {
            GelfLogObject gelfLogObject = new GelfLogObject();
            gelfLogObject.withShortMessage(line);
            return gelfLogObject;
        }
    }

    public void validateUniqueTraceid(String deployment, int numberOfUniqueTraceIds) {
        LOGGER.info("Reading logs...");
        String logContent = kubectlInterface.readLogs(deployment);
        LOGGER.info("Logs fetched.");

        final List<GelfLogObject> logs = buildGelfLogObjectsList(logContent);

        Assert.assertTrue(checkNumberOfUniqueTraceIdsInLogMessages(logs, numberOfUniqueTraceIds));
    }

    public void validateLogs(String deployment, String filePath) throws IOException {
        LOGGER.info("Reading logs...");
        String logContent = kubectlInterface.readLogs(deployment);
        if (logContent.isEmpty()) {
            Assert.fail("No logs were read from pod:" + deployment);
        }

        LOGGER.info("Logs fetched.");

        final List<GelfLogObject> logs = buildGelfLogObjectsList(logContent);
        if (logs.isEmpty()) {
            Assert.fail("No logs were transformed into proper GELF format objects:" + deployment);
        }

        final List<ExpectedLogEntry> expectedLogEntries = extractExpectedLogs(filePath);

        expectedLogEntries.forEach(f ->
                logs.stream()
                        .filter(g -> g.getShortMessage().matches(f.getLogEntry()))
                        .findFirst()
                        .orElseThrow(
                                () -> {
                                    final String logsContent = logs.stream().map(GelfLogObject::getShortMessage).collect(Collectors.joining(", "));
                                    throw new RuntimeException("The log line " + f.getLogEntry() + " was not found in logs. Logs:" + logsContent);
                                }
                        )
        );
    }


    public String logProcessing(String logcontent) {
        String logcontentAfterProcessed = null;
        logcontentAfterProcessed = logcontent.replaceAll(TIMESTAMP1REGEX, "date");
        logcontentAfterProcessed = logcontentAfterProcessed.replaceAll(TIMESTAMP2REGEX, "date");
        logcontentAfterProcessed = logcontentAfterProcessed.replaceAll(ALPHANUM16REGEX, "testdata");
        logcontentAfterProcessed = logcontentAfterProcessed.replaceAll(NUM1REGEX, "1234");
        return logcontentAfterProcessed;

    }

    public void validateLogsContent(String deployment, String filePath) throws IOException {
        LOGGER.info("Reading logs...");
        String actuallog = kubectlInterface.readLogs(deployment);
        LOGGER.info("Logs fetched.");
        String expectedLogs = Files.readString(Paths.get(filePath));
        String processed_actuallog = logProcessing(actuallog);
//        LOGGER.info("logs are : " + actuallog);
        String processed_expectedLogs = logProcessing(expectedLogs);
        Assert.assertTrue("Expected logs: " + processed_expectedLogs
                        + " Actual logs: " + processed_actuallog
                , processed_actuallog.contains(processed_expectedLogs));
        LOGGER.info("Logs were successfully verified.");
    }

    private List<GelfLogObject> buildGelfLogObjectsList(String logContent) {
        final String[] lines = logContent
                .replaceAll("\\{\\s+", "{")
                .replaceAll("\\n *\\}", "}\n")
                .split("\\n");

        return Stream.of(lines)
                .filter(StringUtils::isNotBlank)
                .map(this::readLogObject)
                .collect(Collectors.toList());
    }

    private boolean checkNumberOfUniqueTraceIdsInLogMessages(List<GelfLogObject> logMessages, int numberOfUniqueTraceIds) {
        Set<String> traceIds = logMessages.stream()
                .filter(logMessage -> StringUtils.isNotBlank(logMessage.getTraceId()))
                .map(GelfLogObject::getTraceId)
                .collect(Collectors.toSet());
        return traceIds.size() == numberOfUniqueTraceIds;
    }

    public void verifyLogsLineByLine(String deployment, String filePath) throws IOException {
        LOGGER.info("Reading actual logs for: " + deployment);
        String actualContent = kubectlInterface.readLogs(deployment);
        LOGGER.info("Logs fetched.");

        LOGGER.info("Reading Expected logs for: " + deployment);
        final String expectedLogs = FileUtils.readFileToString(new File(filePath), StandardCharsets.UTF_8);

        LOGGER.info("Verifying logs for: " + deployment);
        final List<String> actualLogLines = Arrays.stream(actualContent.split("\n")).collect(Collectors.toList());
        final List<String> expectedLogLines = Arrays.stream(expectedLogs.split("\n")).collect(Collectors.toList());

        final List<String> notFoundLogLines = expectedLogLines.stream()
                .filter(f -> actualLogLines.stream().noneMatch(actualLine -> actualLine.contains(f)))
                .collect(Collectors.toList());

        Assert.assertTrue("The following log lines were not found:" + String.join(", ", notFoundLogLines)
                        + " Actual logs: " + String.join(", ", actualLogLines),
                notFoundLogLines.isEmpty());
    }

    public void verifyLogs(String deployment, String filePath) throws IOException {
        LOGGER.info("Reading Actual logs for: " + deployment);
        ArrayList<String> listOfLinesAct = readStringLineWise(deployment);
//        listOfLinesAct.stream().forEach(f -> System.out.println("ACTUAL LINE OF LOG: " + f));
        LOGGER.info("Reading Expected logs for: " + deployment);
        ArrayList<String> listOfLinesExp = readStringLineWise(filePath);

        LOGGER.info("Verifying logs for: " + deployment);
        for (String exp : listOfLinesExp) {
            boolean flag = false;
            for (String act : listOfLinesAct) {
                if (act.contains(exp)) {
                    flag = true;
                    break;
                }
            }
            Assert.assertTrue(
                    "Actual Logs doesn't contain expected log line: " + exp
                            + " ACTUAL LOGS: " + listOfLinesAct,
                    flag);
        }

        LOGGER.info("Logs were successfully verified for: " + deployment);
    }

    private ArrayList<String> readStringLineWise(String str) throws IOException {
        BufferedReader bufferedReader = null;
        if (str.contains(".txt")) {
            bufferedReader = new BufferedReader(new FileReader(str));
        } else if (str.contains("tsy-integration")) {
            bufferedReader = kubectlInterface.readLogsAsBufferReader(str);
        } else {
            Assert.fail("Invalid String");
        }
        ArrayList<String> listOfLines = new ArrayList<>();
        String line = bufferedReader.readLine();
        while (line != null) {
            listOfLines.add(line);
            line = bufferedReader.readLine();
        }
        bufferedReader.close();
        return listOfLines;
    }
}
