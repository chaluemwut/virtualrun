package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.UserRunRepository;
import rmuti.runnerapp.model.table.UserRun;

import java.util.List;

@RestController
@RequestMapping("/user_run")
public class UserRunController {
    @Autowired
    private UserRunRepository userRunRepository;
    @PostMapping("/save_run")
    public Object saveRun(UserRun userRun){
        APIResponse res = new APIResponse();
        System.out.println(userRun);
        userRunRepository.save(userRun);
        res.setData(userRun);
        return res;
    }
    @PostMapping("/show_run")
    public Object showRun(){
        APIResponse res = new APIResponse();
        List<UserRun> dbRun = userRunRepository.findAll();
        res.setData(dbRun);
        return  res;
    }
}
