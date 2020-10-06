package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.FullRepository;
import rmuti.runnerapp.model.table.Full;

import java.util.List;

@RestController
@RequestMapping("/mini")
public class FullController {
    @Autowired
    private FullRepository fullRepository;
    @PostMapping("/save_full")
    public Object saveFull(Full full){
        APIResponse res = new APIResponse();
        fullRepository.save(full);
        res.setData(full);
        res.setStatus(1);
        res.setMessage("ok");
        return res;
    }
    @PostMapping("/check_full")
    public Object check(){
        APIResponse res = new APIResponse();
        List<Full> dbFull = fullRepository.findAll();
        res.setData(dbFull);
        return res;
    }
}
