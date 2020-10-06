package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.UserFunRunRepository;
import rmuti.runnerapp.model.service.UserProfileRepository;
import rmuti.runnerapp.model.table.UserFunRun;

import java.util.List;

@RestController
@RequestMapping("/user_funrun")
public class UserFunRunController {
    @Autowired
    private UserFunRunRepository userFunRunRepository;
    @PostMapping("/save_fun_run")
    public Object saveFunRun(UserFunRun userFunRun){
        APIResponse res = new APIResponse();
        UserFunRun db = userFunRunRepository.findByUserNameFun(userFunRun.getUserNameFun());
        if(db==null){
            userFunRunRepository.save(userFunRun);
            res.setMessage("save");
            res.setStatus(1);
            res.setData(1);
        }else{
            res.setData(0);
            res.setStatus(0);
            res.setMessage("Registered");
        }
        return res;
    }
    @PostMapping("/check")
    public Object check(){
        APIResponse res = new APIResponse();
        List<UserFunRun> dbFun = userFunRunRepository.findAll();
        res.setData(dbFun);
        System.out.print(res);
        return res;
    }
}
