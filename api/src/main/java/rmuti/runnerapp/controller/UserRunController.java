package rmuti.runnerapp.controller;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import rmuti.runnerapp.model.service.AllRunRepository;
import rmuti.runnerapp.model.service.UserRunRepository;
import rmuti.runnerapp.model.table.AllRun;
import rmuti.runnerapp.model.table.UserRun;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/user_run")
public class UserRunController {
    @Autowired
    private UserRunRepository userRunRepository;
    @Autowired
    private AllRunRepository allRunRepository;
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
    @PostMapping("/test_show")
    public Object testShow(@RequestParam int userId){
        APIResponse res = new APIResponse();
        List<UserRun> userRuns = userRunRepository.findByUserId(userId);
        List<Integer> value = new ArrayList<Integer>();

        for(var i=0;i< userRuns.size();i++){
            var sum = userRuns.get(i);
            var aid = sum.getAid();
            value.add(aid);
        }
        System.out.println(value);
        List<AllRun> retAllRun = new ArrayList<>();
        for(var i=0;i< value.size();i++) {
            var sum = value.get(i);
            List<AllRun> allRuns = allRunRepository.findByaid(sum);
            var aa = allRuns.get(0);
            retAllRun.add(aa);
        }
        res.setData(retAllRun);
        return  res;
    }
    @GetMapping("/get_data")
    public Object getData(@RequestParam int userId){
        APIResponse res = new APIResponse();
        List<UserRun> userRuns = userRunRepository.findByUserId(userId);
        List<Integer> value = new ArrayList<Integer>();

        for(var i=0;i< userRuns.size();i++){
            var sum = userRuns.get(i);
            var aid = sum.getAid();
            value.add(aid);
        }
        System.out.println(value);
        List<AllRun> retAllRun = new ArrayList<>();
        for(var i=0;i< value.size();i++) {
            var sum = value.get(i);
            List<AllRun> allRuns = allRunRepository.findByaid(sum);
            var aa = allRuns.get(0);
            retAllRun.add(aa);
        }
        res.setData(retAllRun);
        return  res;
    }
}
