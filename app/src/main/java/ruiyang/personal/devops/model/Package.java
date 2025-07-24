package ruiyang.personal.devops.model;

import java.util.ArrayList;
import java.util.List;

public class Package {
    private final String name;
    private final String description;
    private final List<String> dependencies;
    private final List<String> reverseDependencies;

    public Package(String name, String description, List<String> dependencies) {
        this.name = name;
        this.description = description;
        this.dependencies = dependencies;
        this.reverseDependencies = new ArrayList<>();
    }

    public Package(String name, String description, List<String> dependencies, List<String> reverseDependencies) {
        this.name = name;
        this.description = description;
        this.dependencies = dependencies;
        this.reverseDependencies = reverseDependencies;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public List<String> getDependencies() {
        return dependencies;
    }

    public List<String> getReverseDependencies() {
        return reverseDependencies;
    }

    @Override
    public String toString() {
        return "Package{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", dependencies=" + dependencies +
                ", reverseDependencies=" + reverseDependencies +
                '}';
    }
}
