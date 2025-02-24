package ruiyang.personal.devops.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import ruiyang.personal.devops.model.Package;
import ruiyang.personal.devops.service.PackageService;

import java.io.IOException;
import java.util.List;

@RestController

public class PackageController {
    private final PackageService packageService;
    @Autowired
    public PackageController(PackageService packageService) {
        this.packageService = packageService;
    }

    @GetMapping("packages")
    public List<Package> getAllPackages(
            ) throws IOException {
        return packageService.getAllPackages();
    }

    @GetMapping("hi")
    public String hi(
            ) throws IOException {
        return "Hello world";
    }
}
