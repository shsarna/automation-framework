package com;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RestTestUtil {

    public  String getValueByJPath(JSONObject responsejson, String jpath) throws JSONException {
        Object obj = responsejson;
        for (String s : jpath.split("/"))
            if (!s.isEmpty())
                if (!(s.contains("[") || s.contains("]")))
                    obj = ((JSONObject) obj).get(s);
                else if (s.contains("[") || s.contains("]"))
                    obj = ((JSONArray) ((JSONObject) obj).get(s.split("\\[")[0])).get(Integer.parseInt(s.split("\\[")[1].replace("]", "")));
        return obj.toString();
    }
}