package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.UserProfileRepository;
import rmuti.runnerapp.model.table.UserProfile;
import rmuti.runnerapp.util.EncoderUtil;

import java.util.List;

@RestController
@RequestMapping("/user_profile")
public class UserProfileController {

    @Autowired
    private EncoderUtil encoderUtil;

    @Autowired
    private UserProfileRepository userProfileRepository;

    @PostMapping("/save")
    public Object save(UserProfile userProfile) {
        APIResponse res = new APIResponse();
        UserProfile db = userProfileRepository.findByUserName(userProfile.getUserName());
        System.out.print(db);
        if (db == null) {
            userProfile.setPassWord(encoderUtil.passwordEncoder().encode(userProfile.getPassWord()));
            userProfileRepository.save(userProfile);
            res.setStatus(1);
            res.setMessage("ok");
            res.setData(userProfile);
            // res.dataReturn(0);
            res.setData(1);
        } else {
            res.setStatus(0);
            res.setMessage("have Usered");
            //res.dataReturn(1);
            res.setData(0);
        }

        System.out.print(res);
        return res;
    }

    @PostMapping("/login")
    public Object Login(@RequestParam String userName, @RequestParam String passWord) {
        APIResponse res = new APIResponse();
        UserProfile dbUserProfile = userProfileRepository.findByUserNameAndPassWord(userName, passWord);
        System.out.print(dbUserProfile);
        UserProfile db = userProfileRepository.findByUserName(userName);
        System.out.print(db);
        if (dbUserProfile == null) {
            res.setMessage("no user");
            res.setData(0);
            res.setStatus(0);
        } else {
            res.setMessage("Have user");
            res.setData(1);
            res.setStatus(1);
            res.setGetId(db.getUserId());
        }
        return res;
    }

    @PostMapping("/load")
    public Object load() {
        APIResponse res = new APIResponse();
        List<UserProfile> db = userProfileRepository.findAll();
        res.setData(db);
        return res;
        //return userProfileRepository.findAll();
    }
}

