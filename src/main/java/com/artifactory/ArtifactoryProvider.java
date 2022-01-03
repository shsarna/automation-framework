package com.artifactory;

import com.exception.OACustomException;
import com.exception.OACustomException.ExceptionType;
import org.assertj.core.internal.bytebuddy.asm.Advice;
import org.jfrog.artifactory.client.Artifactory;
import org.jfrog.artifactory.client.ArtifactoryClient;
import org.jfrog.artifactory.client.DownloadableArtifact;
import org.jfrog.artifactory.client.UploadableArtifact;
import org.jfrog.artifactory.client.model.LightweightRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;

import static org.jfrog.artifactory.client.model.impl.RepositoryTypeImpl.LOCAL;


import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Locale;

@Component
@Profile("test")
public class ArtifactoryProvider {

    private static final Logger LOGGER = LoggerFactory.getLogger(ArtifactoryProvider.class);

    private static final String FILE_NOT_FOUND_ON_ARTIFACTORY = "The file was not found on the Artifactory.";
    private static final String PROBLEM_UPLOADING_TO_ARTIFACTORY = "There was a problem uploading the file to Artifactory.";

    @Value("${artifactory.url}")
    private String artifactoryUrl;

    @Value("${artifactory.user}")
    private String artifactoryUser;

    @Value("${artifactory.pass}")
    private String artifactoryPass;

    @Value("${artifactory.repository}")
    private String artifactoryRepository;

    private Artifactory artifactory;

    public void upload(String fileWithPath, File file) {

        try {
            createConnection();

            LOGGER.debug("Starting to upload {} to the artifactory.", fileWithPath);
            UploadableArtifact artifact = artifactory.repository(artifactoryRepository).upload(fileWithPath, file);
            artifact.doUpload();
            LOGGER.debug("Successfully uploaded {} to the sources ZIP folder on the Artifactory.", fileWithPath);

        } catch (Exception e) {
            LOGGER.error(PROBLEM_UPLOADING_TO_ARTIFACTORY);
            throw new OACustomException(ExceptionType.SERVER, PROBLEM_UPLOADING_TO_ARTIFACTORY);
        }

        LOGGER.info("File Successfully uploaded to Artifactory.");
    }

    public boolean download(String fileWithPath) {
        InputStream responseStream;
        boolean checkSizeArtifactoryfile = false;
        try {
            createConnection();
            LOGGER.info("Starting to download {} from the artifactory.", fileWithPath);
            List<LightweightRepository> localRepoList = artifactory.repositories().list(LOCAL);
            for (int i = 0; i < localRepoList.size(); i++) {
                System.out.println(localRepoList.get(i));
            }
            DownloadableArtifact item = artifactory.repository(artifactoryRepository).download(fileWithPath);
            responseStream = item.doDownload();
            checkSizeArtifactoryfile = responseStream.available() > 0;
            LOGGER.info("Successfully downloaded {} to temporary file.", fileWithPath);
        } catch (Exception e) {
            LOGGER.error(FILE_NOT_FOUND_ON_ARTIFACTORY);
        }
        return checkSizeArtifactoryfile;


    }

    public boolean downloadswfartifactoryfile(String fileWithPath) {
        InputStream responseStream;
        boolean checkSizeArtifactoryfile = false;
        try {
            createConnectionToSWFArtifactory();
            LOGGER.info("Starting to download {} from the swf artifactory.", fileWithPath);
            List<LightweightRepository> localRepoList = artifactory.repositories().list(LOCAL);
            for (int i = 0; i < localRepoList.size(); i++) {
                System.out.println(localRepoList.get(i));
            }
            DownloadableArtifact item = artifactory.repository(artifactoryRepository).download(fileWithPath);
            responseStream = item.doDownload();
            checkSizeArtifactoryfile = responseStream.available() > 0;
            LOGGER.info("Successfully downloaded {} to temporary file.", fileWithPath);
        } catch (Exception e) {
            LOGGER.error(FILE_NOT_FOUND_ON_ARTIFACTORY);
        }
        return checkSizeArtifactoryfile;


    }


    public void swfArtifactoryConnection() {
        InputStream responseStream;
        boolean checkSizeArtifactoryfile = false;
        try {
            createConnectionToSWFArtifactory();

            List<LightweightRepository> localRepoList = artifactory.repositories().list(LOCAL);
            for (int i = 0; i < localRepoList.size(); i++) {
                System.out.println(localRepoList.get(i));
            }

        } catch (Exception e) {
            LOGGER.error("error while connection to SWF artifactory");
        }


    }


    private void createConnection() {
        LOGGER.debug("Trying to connect to the artifactory using URL: {}, user: {} and password: {}", artifactoryUrl,
                artifactoryUser, artifactoryPass);
        artifactory = ArtifactoryClient.create(artifactoryUrl, artifactoryUser, artifactoryPass);
        LOGGER.debug("The connection to the artifactory was successful.");
    }

    public void createConnectionToSWFArtifactory() {

        try {
            LOGGER.debug("Trying to connect to the artifactory using URL: {}, user: {} and password: {}", artifactoryUrl,
                    artifactoryUser, artifactoryPass);
            artifactory = ArtifactoryClient.create("https://artifact.swf.daimler.com/webapp/#/artifacts/browse/tree/General/apricot-bin-delivery/swup/digital-owner-manual", "digital_owner_manual_techuser", "a8lp2BQKmYnz0XBavswW8A+");
            LOGGER.debug("The connection to the artifactory was successful.");
        } catch (Exception e) {
            LOGGER.error("The connection to the artifactory failed");
        }
    }
}
