package rmuti.runnerapp.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.AllRunRepository;

@RestController
@RequestMapping("/all_run")
public class AllRunController {
    private AllRunRepository allRunRepository;
    public Object save(){
        return null;
    }
}
