package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.UserHalfRepository;
import rmuti.runnerapp.model.table.UserHalf;

import java.util.List;

@RestController
@RequestMapping("/user_half")
public class UserHalfController {
    @Autowired
    private UserHalfRepository userHalfRepository;
    @PostMapping("/save_half")
    public Object saveHalf(UserHalf userHalf){
        APIResponse res = new APIResponse();
        UserHalf db = userHalfRepository.findByUserNameHalf(userHalf.getUserNameHalf());
        if(db == null){
            userHalfRepository.save(userHalf);
            res.setData(userHalf);
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
        List<UserHalf> dbHalf = userHalfRepository.findAll();
        res.setData(dbHalf);
        return res;
    }
}
