package com;

import com.model.Configmap;
import com.model.HorizontalPodAutoscaler;
import com.model.Scale;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import static java.util.Arrays.asList;

@Component
public class KubernetesUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(KubernetesUtils.class);


    public void applyPropertyToConfigmap(String cmName, String property, String value) {
        LOGGER.info("Editing configmap {} property {}", cmName, property);

        String namespace = namespace(cmName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/api/v1/namespaces/" + namespace + "/configmaps/" + cmName;
        LOGGER.info("URL: {}", url);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Configmap> configmapResponse = restTemplate.getForEntity(url, Configmap.class);

        Configmap configmap = configmapResponse.getBody();

        Map<String, String> data = configmap.getData();
        String applicationProperties = data.get("application.properties");
        List<String> propertyLines = asList(applicationProperties.split(StringUtils.LF));

        Map<String, String> propertyMap = propertyLines.stream()
                .map(prop -> {
                    if (prop.contains("=") && !prop.contains(":")) {
                        return new String[]{prop.substring(0, prop.indexOf("=")), prop.substring(prop.indexOf("=") + 1)};
                    }
                    if (prop.contains(":") && !prop.contains("=")) {
                        return new String[]{prop.substring(0, prop.indexOf(":")), prop.substring(prop.indexOf(":") + 1)};
                    }

                    if (prop.indexOf("=") < prop.indexOf(":")) {
                        return new String[]{prop.substring(0, prop.indexOf("=")), prop.substring(prop.indexOf("=") + 1)};
                    } else {
                        return new String[]{prop.substring(0, prop.indexOf(":")), prop.substring(prop.indexOf(":") + 1)};
                    }
                })
                .collect(Collectors.toMap(prop -> prop[0].trim(), val -> val[1].trim()));

        propertyMap.put(property, value);

        List<String> resultPropertyList = propertyMap.entrySet().stream().map(e -> e.getKey() + " = " + e.getValue()).collect(Collectors.toList());

        String join = StringUtils.join(resultPropertyList, StringUtils.LF);

        configmap.getData().put("application.properties", join);

        restTemplate.put(url, configmap);

    }

    //dev
    public void applyPropertyToConfigmap(String cmName, String property, String value, String propertyFileName) {
        LOGGER.info("Editing configmap {} property {}", cmName, property);

        String namespace = namespace(cmName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/api/v1/namespaces/" + namespace + "/configmaps/" + cmName;
        LOGGER.info("URL: {}", url);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Configmap> configmapResponse = restTemplate.getForEntity(url, Configmap.class);

        Configmap configmap = configmapResponse.getBody();

        Map<String, String> data = configmap.getData();
        String applicationProperties = data.get(propertyFileName);
        List<String> propertyLines = asList(applicationProperties.split(StringUtils.LF));

        Map<String, String> propertyMap = propertyLines.stream()
                .filter(prop -> !isCommentedLine(prop))
                .map(prop -> {
                    if (prop.contains("=") && !prop.contains(":")) {
                        return new String[]{prop.substring(0, prop.indexOf("=")), prop.substring(prop.indexOf("=") + 1)};
                    }
                    if (prop.contains(":") && !prop.contains("=")) {
                        return new String[]{prop.substring(0, prop.indexOf(":")), prop.substring(prop.indexOf(":") + 1)};
                    }

                    if (prop.indexOf("=") < prop.indexOf(":")) {
                        return new String[]{prop.substring(0, prop.indexOf("=")), prop.substring(prop.indexOf("=") + 1)};
                    } else {
                        return new String[]{prop.substring(0, prop.indexOf(":")), prop.substring(prop.indexOf(":") + 1)};
                    }
                })
                .collect(Collectors.toMap(prop -> prop[0].trim(), val -> val[1].trim()));

        propertyMap.put(property, value);

        List<String> resultPropertyList = propertyMap.entrySet().stream().map(e -> e.getKey() + " = " + e.getValue()).collect(Collectors.toList());

        String join = StringUtils.join(resultPropertyList, StringUtils.LF);

        configmap.getData().put(propertyFileName, join);

        restTemplate.put(url, configmap);

    }

    public String getProperty(String cmName, String property) {
        LOGGER.info("Editing configmap {} property {}", cmName, property);

        String namespace = namespace(cmName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/api/v1/namespaces/" + namespace + "/configmaps/" + cmName;
        LOGGER.info("URL: {}", url);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Configmap> configmapResponse = restTemplate.getForEntity(url, Configmap.class);

        Configmap configmap = configmapResponse.getBody();

        Map<String, String> data = configmap.getData();
        String applicationProperties = data.get("application.properties");
        List<String> propertyLines = asList(applicationProperties.split(StringUtils.LF));

        Map<String, String> propertyMap = propertyLines.stream()
                .map(prop -> {
                    if (prop.contains("=") && !prop.contains(":")) {
                        return new String[]{prop.substring(0, prop.indexOf("=")), prop.substring(prop.indexOf("=") + 1)};
                    }
                    if (prop.contains(":") && !prop.contains("=")) {
                        return new String[]{prop.substring(0, prop.indexOf(":")), prop.substring(prop.indexOf(":") + 1)};
                    }

                    if (prop.indexOf("=") < prop.indexOf(":")) {
                        return new String[]{prop.substring(0, prop.indexOf("=")), prop.substring(prop.indexOf("=") + 1)};
                    } else {
                        return new String[]{prop.substring(0, prop.indexOf(":")), prop.substring(prop.indexOf(":") + 1)};
                    }
                })
                .collect(Collectors.toMap(prop -> prop[0].trim(), val -> val[1].trim()));

        return propertyMap.get(property);
    }

    private boolean isCommentedLine(String logLine) {
        String logLineWithoutWhiteSpaces = logLine.trim();
        return logLineWithoutWhiteSpaces.startsWith("#");
    }

    private static String namespace(String cmName) {
        Map<String, List<String>> namespaceToCm = Map.of(
                BA_NTG_7, List.of("dom-container-service", "dom-content-service", "dom-online-facade",
                        "dom-online-package-service", "dom-sw-service", "dom-ui-data-service", "dom-validation-service",
                        "oa-gw-data-service"),

                BA_OACORE, List.of("oa-content-service", "xxxml-import-service", "standalone-adapter", "dom-view", "arki-dom-preview-service")

//                BA_PREVIEW, List.of("arki-dom-preview-service", "dom-preview", "dom-view")
        );

        Set<Map.Entry<String, List<String>>> entries = namespaceToCm.entrySet();

        for (Map.Entry<String, List<String>> entry : entries) {
            List<String> services = entry.getValue();

            if (services.stream().anyMatch(cmName::startsWith)) {
                return entry.getKey();
            }

        }
        throw new IllegalArgumentException(cmName + "cannot be mapped to a namespace");
    }

    public void restartDeployment(String deploymentName) {
        LOGGER.info("Restarting deployment {}...", deploymentName);
        String namespace = namespace(deploymentName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/apis/apps/v1/namespaces/" + namespace + "/deployments/" + deploymentName + "/scale";
        LOGGER.info("URL: {}", url);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Scale> scaleEntity = restTemplate.getForEntity(url, Scale.class);

        Scale scale = scaleEntity.getBody();

        int replicas = scale.getSpec().getReplicas();
        scale.getSpec().setReplicas(0);

        restTemplate.put(url, scale);

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        ResponseEntity<Scale> stoppedScaleEntity = restTemplate.getForEntity(url, Scale.class);

        Scale stoppedScale = stoppedScaleEntity.getBody();

        stoppedScale.getSpec().setReplicas(replicas);

        restTemplate.put(url, stoppedScale);

    }

    public void changeHpa(String hpaName, int minPods, int maxPods) {
        LOGGER.info("Editing hpa {}...", hpaName);
        String namespace = KubernetesUtils.namespace(hpaName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/apis/autoscaling/v1/namespaces/" + namespace + "/horizontalpodautoscalers/" + hpaName;

        LOGGER.info("URL: {}", url);
        RestTemplate restTemplate = new RestTemplate();
        var hpaEntity = restTemplate.getForEntity(url, HorizontalPodAutoscaler.class);

        HorizontalPodAutoscaler hpa = hpaEntity.getBody();

        hpa.getSpec().setMinReplicas(minPods).setMaxReplicas(maxPods);

        restTemplate.put(url, hpa);

    }

    public void setPodCount(String deploymentName, int podCount) {
        String namespace = namespace(deploymentName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/apis/apps/v1/namespaces/" + namespace + "/deployments/" + deploymentName + "/scale";
        LOGGER.info("URL: {}", url);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Scale> scaleEntity = restTemplate.getForEntity(url, Scale.class);

        Scale scale = scaleEntity.getBody();

        scale.getSpec().setReplicas(podCount);

        restTemplate.put(url, scale);

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public int getPodCount(String deploymentName) {
        String namespace = namespace(deploymentName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/apis/apps/v1/namespaces/" + namespace + "/deployments/" + deploymentName + "/scale";

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Scale> scaleEntity = restTemplate.getForEntity(url, Scale.class);

        Scale scale = scaleEntity.getBody();

        return scale.getSpec().getReplicas();
    }


    public int getPodStatus(String deploymentName) throws JSONException {
        String namespace = namespace(deploymentName);

        String url = "http://localhost:" + NAMESPACE_TO_PORTS.get(namespace) + "/apis/apps/v1/namespaces/" + namespace + "/deployments/" + deploymentName + "/status";

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> statusResponseEntity = restTemplate.getForEntity(url, String.class);
        String deploymentStatus = statusResponseEntity.getBody();
        JSONObject jsonObject = new JSONObject(deploymentStatus);
        JSONObject status = jsonObject.getJSONObject("status");
        int availableReplicas = status.getInt("availableReplicas");
        if (deploymentStatus != null) {
            return availableReplicas;
        } else {
            throw new RuntimeException("Deployment " + deploymentName + " is not a valid deployment name");
        }

    }
}
