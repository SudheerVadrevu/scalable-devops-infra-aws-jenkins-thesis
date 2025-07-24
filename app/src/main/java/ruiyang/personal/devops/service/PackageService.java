package ruiyang.personal.devops.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import ruiyang.personal.devops.model.Package;
import ruiyang.personal.devops.utils.PackageUtils;

@Service
public class PackageService {
    public List<Package> getAllPackages() throws IOException {
        InputStream in = getClass().getResourceAsStream("/data/status.real"); 
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        String result = reader.lines().collect(Collectors.joining("\n"));
        reader.close();
        List<String> packages = Arrays.asList(result.split("\n\n"));
        return packages.stream().map(p -> new Package(PackageUtils.getName(p), PackageUtils.getDescription(p), PackageUtils.getDependencies(p))).collect(Collectors.toList());
    }
}
