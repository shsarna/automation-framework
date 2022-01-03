package com;

import com.model.AssertColumnModel;
import com.model.AssertCountModel;
import com.model.AssertRowModel;
import com.model.SelectColumnModel;
import com.model.arkidompreviwdb.Preview;
import com.model.arkidompreviwdb.PreviewProperty;
import com.model.domswdb.DomSwRelease;
import com.model.oaimportdb.XxxmlImport;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.*;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.Assert.assertEquals;

@Component
public class DatabaseUtility {

    public static final String BASE_TEST_PATH = "src/test/resources";

    private static final Logger LOGGER = LoggerFactory.getLogger(DatabaseUtility.class);

    @Autowired
    ObjectMapper objectMapper;

    public void verifyDbRow(String tableName, String valuesFilePath) throws IOException, InterruptedException {
        if (valuesFilePath == null || !valuesFilePath.contains(".json")) {
            return;
        }
        EntityManager entityManager = getEntityManager(tableName);
        AssertRowModel assertRowModel = objectMapper.readValue(new File(BASE_TEST_PATH + valuesFilePath),
                AssertRowModel.class);
        List<AssertColumnModel> columnAssertModels = assertRowModel.getAssertColumnModels();
        List<SelectColumnModel> selectColumnModels = assertRowModel.getSelectColumnModels();

        String selectConditions = "1 = 1";
        if (!selectColumnModels.isEmpty())
            selectConditions = selectColumnModels
                    .stream()
                    .map(selectColumnModel ->
                            String.format("CAST (%s AS character varying) LIKE '%s'",
                                    selectColumnModel.getColumnName(),
                                    selectColumnModel.getColumnValue())
                    )
                    .collect(Collectors.joining(" AND "));

        String query = String.format("SELECT %s FROM %s WHERE %s;",
                columnAssertModels
                        .stream()
                        .map(AssertColumnModel::getColumnName)
                        .collect(Collectors.joining(", ")),
                tableName, selectConditions
        );

        LOGGER.info(query);
        List<Object[]> results = entityManager.createNativeQuery(query).getResultList();
        if (results.size() != 1) {

            throw new AssertionError(String.format("None or too many rows were found with these values: \n%d\n%s\n%s\n;",
                    results.size(), query, selectColumnModels
                            .stream()
                            .map(selectColumnModel ->
                                    String.format("%s = %s",
                                            selectColumnModel.getColumnName(), selectColumnModel.getColumnValue())
                            )
                            .collect(Collectors.joining("\n"))));


        }
        if (columnAssertModels.size() > 1) {
            for (int i = 0; i < columnAssertModels.size(); i++) {
                assertEquals("!Failed! Expected: " + columnAssertModels.get(0).getColumnName() + ": " + columnAssertModels.get(i).getColumnValue() +
                                "Actual: " + results.get(0)[i],
                        columnAssertModels.get(i).getColumnValue(), String.valueOf(results.get(0)[i]));
            }
        } else {
            if (tableName.equalsIgnoreCase("xxxml_v10_import.xxxml_import")) {
                Thread.sleep(30000);
            }
            assertEquals("!Failed! Expected: " + columnAssertModels.get(0).getColumnName() + ": " + columnAssertModels.get(0).getColumnValue() +
                            "\n Actual: " + results.get(0)
                    , columnAssertModels.get(0).getColumnValue(), String.valueOf(results.get(0)));
        }
    }

    public void verifyCountOfObjects(String tableName, String valuesFilePath) throws IOException, InterruptedException {
        AssertCountModel assertCountModel = getAssertCountModel(valuesFilePath);
        EntityManager entityManager = getEntityManager(tableName);

        LOGGER.info("Count objects statement: {}", assertCountModel.getSelectStatement());
        Query result = entityManager.createNativeQuery(assertCountModel.getSelectStatement());
        int count = ((BigInteger) result.getResultList().get(0)).intValue();
        for (int i = 1; i <= 3; i++) {
            try {
                assertEquals(assertCountModel.getExpectedCount(), count);
            } catch (AssertionError fail) {
                LOGGER.info("!!! FAILED !!! expected count didn't match. Waiting for DB update.");
                Thread.sleep(5000);
            }
        }

    }

    public void verifySqlLiteCountOfObjects(String flashwareLocation,
                                            String database,
                                            String valuesFilePath) throws SQLException, IOException {

        AssertCountModel assertCountModel = getAssertCountModel(valuesFilePath);

        try (Connection connection = getConnection(FLASHWARE_RESULTS_FOLDER + "/"
                + flashwareLocation + VEHICLE_DBS_FOLDER, database)) {

            try (Statement statement = connection.createStatement()) {
                final String sqlQuery = assertCountModel.getSelectStatement();
                LOGGER.info(sqlQuery);
                final ResultSet resultSet = statement.executeQuery(sqlQuery);

                // rs should have 1 row only
                if (resultSet.next()) {
                    assertEquals(assertCountModel.getExpectedCount(), resultSet.getInt(1));
                } else {
                    throw new RuntimeException("No row returned from query: " + sqlQuery);
                }
            }
        }
    }

    public void verifySqlLiteCountOfCosObjects(String cosfilepath,
                                               String valuesFilePath) throws SQLException, IOException {

        AssertCountModel assertCountModel = getAssertCountModel(valuesFilePath);

        try (Connection connection = getConnection2(cosfilepath)) {

            try (Statement statement = connection.createStatement()) {
                final String sqlQuery = assertCountModel.getSelectStatement();
                LOGGER.info(sqlQuery);
                final ResultSet resultSet = statement.executeQuery(sqlQuery);

                // rs should have 1 row only
                if (resultSet.next()) {
                    assertEquals(assertCountModel.getExpectedCount(), resultSet.getInt(1));
                } else {
                    throw new RuntimeException("No row returned from query: " + sqlQuery);
                }
            }
        }
    }

    public void checkSqlLiteDb(String flashwareLocation, String database, String table, String valuesFilePath)
            throws IOException, SQLException {

        try (Connection connection = getConnection(FLASHWARE_RESULTS_FOLDER + "/" +
                flashwareLocation + VEHICLE_DBS_FOLDER, database)) {

            assertRowValues(table, connection, new File(valuesFilePath));
        }
    }


    public void checkSqlLiteDbCOSdata(String cosfilepath, String database, String table, String valuesFilePath)
            throws IOException, SQLException {

        try (Connection connection = getConnection2(cosfilepath)) {
            assertRowValues(table, connection, new File(valuesFilePath));
        }
    }

    private void assertRowValues(String tableName, Connection connection, File dbAssert) throws IOException {

        AssertRowModel assertRowModel = objectMapper.readValue(dbAssert, AssertRowModel.class);
        List<AssertColumnModel> columnAssertModels = assertRowModel.getAssertColumnModels();
        List<SelectColumnModel> selectColumnModels = assertRowModel.getSelectColumnModels();

        String selectConditions = "1 = 1";
        if (!selectColumnModels.isEmpty())
            selectConditions = selectColumnModels
                    .stream()
                    .map(selectColumnModel -> {
                                if (selectColumnModel.getColumnValue() == null) {
                                    return String.format("%s IS NULL", selectColumnModel.getColumnName());
                                } else {
                                    return String.format("CAST (%s AS character varying) LIKE '%s'",
                                            selectColumnModel.getColumnName(), selectColumnModel.getColumnValue());

                                }
                            }
                    ).collect(Collectors.joining(" AND "));

        final String sqlQuery = String.format("SELECT %s FROM %s WHERE %s;",
                columnAssertModels.stream()
                        .map(AssertColumnModel::getColumnName)
                        .map(String::toUpperCase)
                        .collect(Collectors.joining(", ")),
                tableName.toUpperCase(), selectConditions);


        LOGGER.info(sqlQuery);
        try (Statement statement = connection.createStatement();
             final ResultSet resultSet = statement.executeQuery(sqlQuery)) {

            // rs should have 1 row only
            if (resultSet.next()) {

                columnAssertModels.forEach(assertColumn -> {
                    try {
                        assertEquals(assertColumn.getColumnValue(), resultSet.getString(assertColumn.getColumnName()));
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    }
                });

            } else {
                throw new RuntimeException("No row returned from query: " + sqlQuery);
            }

        } catch (SQLException throwables) {
            throw new RuntimeException(throwables);
        }
    }

    private Connection getConnection(String baseFolderOfDatabases, String databaseName) {
        final String url = "jdbc:sqlite:" + baseFolderOfDatabases + "/" + databaseName + ".db";
        try {
            return DriverManager.getConnection(url);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            throw new RuntimeException("Could not connect to dom-ui-data.db url:" + url, throwables);
        }
    }

    private Connection getConnection2(String baseFolderOfDatabases) {
        String filepath = baseFolderOfDatabases.substring(1);
        final String url = "jdbc:sqlite:" + baseFolderOfDatabases;
        try {
            return DriverManager.getConnection(url);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            throw new RuntimeException("Could not connect to dom-ui-data.db url:" + url, throwables);
        }
    }

    public AssertCountModel getAssertCountModel(String valuesFilePath) throws IOException {
        return objectMapper.readValue(new File(BASE_TEST_PATH + valuesFilePath),
                AssertCountModel.class);
    }

    public EntityManager getEntityManager(String tableName) {
        EntityManager entityManager;

        if (tableName.contains("xxxml")) {
            entityManager = importDbEntityManager;
        } else if (tableName.contains("oa_content")) {
            entityManager = oaContentDbEntityManager;
        } else if (tableName.contains("dom_content")) {
            entityManager = oaVehicleBackendDbEntityManger;
        } else if (tableName.contains("domui_data_service")) {
            entityManager = domUiDataDbEntityManager;
        }
//        else if (tableName.contains("dom_online")) {
//            entityManager = DomOnlinePackageDbEntityManager;
//        }
        else if (tableName.contains("arki_dom_preview")) {
            entityManager = arkiDomPreviewDbEntityManager;
        } else
//            if (tableName.contains("dom_container"))
        {
            entityManager = domContainerDbEntityManager;
        }

        return entityManager;
    }

    public void checkDBConnection(String dbURL, String userName) {
        try (Connection conn = DriverManager.getConnection(
                dbURL, userName, "")) {

            if (conn != null) {
                System.out.println("Connected to the database!");
            } else {
                System.out.println("Failed to make connection!");
            }

        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Added method to check to DB connection
    public boolean checkDBConnection(String dbURL, String userName, String Password) {
        boolean flag = false;
        try (Connection conn = DriverManager.getConnection(
                dbURL, userName, Password)) {
            if (conn != null) {
                LOGGER.info("/n !!!Checking db connection: " + conn + "!!!\n");
                flag = true;
            } else {
                flag = false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

}

