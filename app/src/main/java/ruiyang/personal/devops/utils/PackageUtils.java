package ruiyang.personal.devops.utils;

import java.util.Arrays;
import java.util.List;

public class PackageUtils {

    public static String getName(String raw){
        return raw.split("\n")[0].split(": ")[1];
    }
    public static String getDescription(String raw){
        StringBuilder description = new StringBuilder();
        boolean inDescription = false;
        for (String line : raw.split("\n")
        ) {
            if (line.startsWith("Description: ")) {
                description.append(line.replace("Description: ", ""));
                inDescription = true;
            }
            if (inDescription && !line.contains("Description: ")) {
                description.append(line);
            } else {
                inDescription = false;
            }
        }
        return description.toString();
    }

    public static List<String> getDependencies(String raw){
        String depString = "";
        for (String line : raw.split("\n")
        ) {
            if (line.startsWith("Depends: ")) {
                depString = line.split(": ")[1];
                break;
            }
        }
        return Arrays.asList(depString.split(", "));
    }
}
