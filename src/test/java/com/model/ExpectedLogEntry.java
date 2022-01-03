package com.model;

public class ExpectedLogEntry {
    private final String logEntry;

    public ExpectedLogEntry(String logEntry) {
        this.logEntry = logEntry;
    }

    public String getLogEntry() {
        return logEntry;
    }

    public static ExpectedLogEntry of(String entry) {
        return new ExpectedLogEntry(entry);
    }
}
