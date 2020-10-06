package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.UserFullRepository;
import rmuti.runnerapp.model.table.UserFull;

import java.util.List;

@RestController
@RequestMapping("/user_full")
public class UserFullController {
    @Autowired
    private UserFullRepository userFullRepository;
    @PostMapping("/save_full")
    public Object saveFull(UserFull userFull){
        APIResponse res = new APIResponse();
        UserFull db = userFullRepository.findByUserNameFull(userFull.getUserNameFull());
        if(db == null){
            userFullRepository.save(userFull);
            res.setData(userFull);
            res.setMessage("ok");
            res.setStatus(1);
        }else{
            res.setData(0);
            res.setMessage("have");
            res.setStatus(0);
        }
        return res;

    }
    @PostMapping("/check")
    public Object check(){
        APIResponse res = new APIResponse();
        List<UserFull> dbFull= userFullRepository.findAll();
        res.setData(dbFull);
        return res;
    }
}
