package com;

import com.exception.OACustomException;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static com.exception.OACustomException.ExceptionType.BUSINESS;
import static java.nio.charset.StandardCharsets.UTF_8;

@Component
public class KubectlInterface {

    public String readLogs(String deployment) {

        try {
            String context = determineContext(deployment);
            new ProcessBuilder().command("kubectl", "config", "set-context", "--current", "--namespace=" + context).start().waitFor();
            final File logFile = new File("logfile.txt");
            logFile.createNewFile();
            final Process process = new ProcessBuilder().command("kubectl", "logs", "deployment/" + deployment)
                    .start();

            InputStream inputStream = process.getInputStream();
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));

            List<String> lines = new ArrayList<>();
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                lines.add(line);
            }

            FileUtils.writeLines(logFile, lines);

            final String logContent = FileUtils.readFileToString(logFile, UTF_8);
            FileUtils.forceDelete(logFile);
            return logContent;
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            throw new OACustomException(BUSINESS, "There was a problem with reading the logs");
        }
    }

    BufferedReader readLogsAsBufferReader(String deployment) {

        try {
            String context = determineContext(deployment);
            new ProcessBuilder().command("kubectl", "config", "set-context", "--current", "--namespace=" + context).start().waitFor();
            final File logFile = new File("logfile.txt");
            logFile.createNewFile();
            final Process process = new ProcessBuilder().command("kubectl", "logs", "deployment/" + deployment)
                    .start();

            InputStream inputStream = process.getInputStream();
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));

            return bufferedReader;
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            throw new OACustomException(BUSINESS, "There was a problem with reading the logs");
        }
    }

}
