package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.*;
import rmuti.runnerapp.model.service.AllRunRepository;
import rmuti.runnerapp.model.table.AllRun;

import java.util.List;

@RestController
@RequestMapping("/all_run")
public class AllRunController {
    @Autowired
    private AllRunRepository allRunRepository;
    @PostMapping("/save_all")
    public Object saveAll(AllRun allRun){
        APIResponse res = new APIResponse();
        allRunRepository.save(allRun);
        res.setData(allRun);
        return res;
    }
    @PostMapping("/show_fun")
    public Object showFun(){
        APIResponse res = new APIResponse();
        List<AllRun> dbFun = allRunRepository.findAll();
        res.setData(dbFun);
        return res;
    }
    @PostMapping("/test")
    public Object test(@RequestParam String type){
        //APIResponse res = new APIResponse();
        List<AllRun> allRuns = allRunRepository.findAllByType(type);

        return allRuns;
    }
    @GetMapping("/testdata")
    public Object testdata(@RequestParam String type){
        List<AllRun> allRuns = allRunRepository.findAllByType(type);
        return allRuns;
    }
}
