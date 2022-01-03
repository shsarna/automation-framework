package com;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;

@Configuration
public class RestTemplateConfig {

    private static final Logger LOGGER = LoggerFactory.getLogger(RestTemplateConfig.class);
    @Bean
    @Primary
    public RestTemplate restTemplate(){
        return new RestTemplate();
    }

    @Bean("restTemplateWithHttps")
    public RestTemplate restTemplateWithHttps(){
        final RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HostnameSslVerificationHttpRequestFactory());
        return restTemplate;
    }

    private static class HostnameSslVerificationHttpRequestFactory extends SimpleClientHttpRequestFactory {

        @Override
        protected void prepareConnection(HttpURLConnection connection, String httpMethod) throws IOException {
            if (connection instanceof HttpsURLConnection) {
                prepareHttpsConnection((HttpsURLConnection) connection);
            }
            super.prepareConnection(connection, httpMethod);
        }

        private void prepareHttpsConnection(HttpsURLConnection connection) {
            connection.setHostnameVerifier(
                    (requestedHost, remoteServerSession) ->
                            requestedHost.equalsIgnoreCase(remoteServerSession.getPeerHost())
            );
            try {
                connection.setSSLSocketFactory(createSslSocketFactory());
            } catch (Exception ex) {
                LOGGER.error("Failed to prepare https connection", ex);
            }
        }

        private SSLSocketFactory createSslSocketFactory() throws Exception {
            SSLContext context = SSLContext.getInstance("TLS");
            context.init(null, new TrustManager[]{new SkipX509TrustManager()}, new SecureRandom());
            return context.getSocketFactory();
        }
    }

    private static class SkipX509TrustManager implements X509TrustManager {

        @Override
        public X509Certificate[] getAcceptedIssuers() {
            return new X509Certificate[0];
        }

        @Override
        public void checkClientTrusted(X509Certificate[] chain, String authType) {
        }

        @Override
        public void checkServerTrusted(X509Certificate[] chain, String authType) {
        }

    }
}
