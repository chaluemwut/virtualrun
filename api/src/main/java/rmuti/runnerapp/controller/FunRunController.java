package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.FunRunRepository;
import rmuti.runnerapp.model.table.FunRun;

import java.util.List;

@RestController
@RequestMapping("/fun_run")
public class FunRunController {
    @Autowired
    private FunRunRepository funRunRepository;
    @PostMapping("/save_fun")
    public Object saveFun(FunRun funRun){
        APIResponse res = new APIResponse();
        funRunRepository.save(funRun);
        res.setData(funRun);
        System.out.print(funRun);
        res.setMessage("ok");
        res.setStatus(1);
        System.out.print(res);
        return res;

    }
    @PostMapping("/check_fun")
    public Object check(){
        APIResponse res = new APIResponse();
        List<FunRun> dbFun = funRunRepository.findAll();
        res.setData(dbFun);
        return res;
    }
}
