package com;

import com.model.rest.OaContentServiceBulkRequestSchema;
import com.model.rest.OaServiceCommonResponseNoDataSchema;
import org.apache.http.Header;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component
public class RestClient {

    @Autowired
    RestTemplate restTemplate;

    CloseableHttpClient httpClient;
    CloseableHttpResponse closeableHttpResponse;

    private ResponseEntity<OaServiceCommonResponseNoDataSchema> bulkResponse;

    //get method without headers
    public int get(String url) throws IOException, JSONException {
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(url);  //http get request
        CloseableHttpResponse closeableHttpResponse = httpClient.execute(httpGet);  //hit the get url

        //code for getting status code
        int statuscode = closeableHttpResponse.getStatusLine().getStatusCode();

        //code for getting json string
        String responseString = EntityUtils.toString(closeableHttpResponse.getEntity(), "UTF-8");
        JSONObject responsejson = new JSONObject(responseString);

        //code for header
        Header[] headersArray = closeableHttpResponse.getAllHeaders();
        HashMap<String, String> allHeaders = new HashMap<String, String>();
        for (Header header : headersArray) {
            allHeaders.put(header.getName(), header.getValue());
        }

        return statuscode;
    }

    //get method with headers
    public void get(String url, HashMap<String, String> headerMap) throws IOException, JSONException {
        httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(url);  //http get request

        for (Map.Entry<String, String> entry : headerMap.entrySet()) {
            httpGet.addHeader(entry.getKey(), entry.getValue());
        }
        closeableHttpResponse = httpClient.execute(httpGet);  //hit the get url

        //code for getting status code
        //int statuscode = closeableHttpResponse.getStatusLine().getStatusCode();
        //code for getting json string
        //JSONObject responsejson = new JSONObject(responseString);

        //code for header
        Header[] headersArray = closeableHttpResponse.getAllHeaders();
        HashMap<String, String> allHeaders = new HashMap<String, String>();
        for (Header header : headersArray) {
            allHeaders.put(header.getName(), header.getValue());
        }


    }

    public int getStatusCode() {
        int statusCode = closeableHttpResponse.getStatusLine().getStatusCode();
        return statusCode;
    }

    public String getResponseJson() throws IOException {
        String responseString = EntityUtils.toString(closeableHttpResponse.getEntity(), "UTF-8");
        return responseString;
    }

    public String getJsonResponse(String url, HashMap<String, String> headerMap) throws JSONException, IOException {

        String responseString = EntityUtils.toString(closeableHttpResponse.getEntity(), "UTF-8");
        return responseString;
    }

    //Post method
    public void post(String url, String entityString, HashMap<String, String> headerMap) throws IOException {
        httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(new StringEntity(entityString));  //for payload

        //for headers
        for (Map.Entry<String, String> entry : headerMap.entrySet()) {
            httpPost.addHeader(entry.getKey(), entry.getValue());
        }
        closeableHttpResponse = httpClient.execute(httpPost);  //hit the get url

    }

    //Post method
    public void oaBulkPost(String url, OaContentServiceBulkRequestSchema entityString, HashMap<String, String> headerMap) throws IOException {

        HttpHeaders httpHeaders = new HttpHeaders();
        for (Map.Entry<String, String> entry : headerMap.entrySet()) {
            httpHeaders.add(entry.getKey(), entry.getValue());
        }
        final HttpEntity<OaContentServiceBulkRequestSchema> body = new HttpEntity<>(entityString, httpHeaders);

        try {
            bulkResponse = new RestTemplate().postForEntity(url, body, OaServiceCommonResponseNoDataSchema.class);
        } catch (HttpClientErrorException cex) {
            bulkResponse = ResponseEntity.status(cex.getStatusCode()).build();
        } catch (Exception e) {
            bulkResponse = ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<OaServiceCommonResponseNoDataSchema> getBulkResponseEntity() {
        return bulkResponse;
    }
}
