package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.UserMiniRepository;
import rmuti.runnerapp.model.table.UserMini;

import java.util.List;

@RestController
@RequestMapping("/user_mini")
public class UserMiniController {
    @Autowired
    private UserMiniRepository userMiniRepository;
    @PostMapping("/save_mini")
    public Object saveMini(UserMini userMini){
        APIResponse res = new APIResponse();
        UserMini db = userMiniRepository.findByUserNameMini(userMini.getUserNameMini());
        if(db==null){
            userMiniRepository.save(userMini);
            res.setData(userMini);
            res.setMessage("ok");
            res.setStatus(1);
        }else {
            res.setStatus(0);
            res.setMessage("have");
            res.setData(0);
        }
        return res;
    }
    @PostMapping("/check_mini")
    public Object check(){
        APIResponse res = new APIResponse();
        List<UserMini> dbMini = userMiniRepository.findAll();
        res.setData(dbMini);
        return res;
    }
}
