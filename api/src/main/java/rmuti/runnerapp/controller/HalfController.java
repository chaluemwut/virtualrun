package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.HalfRepository;
import rmuti.runnerapp.model.table.Half;

import java.util.List;

@RestController
@RequestMapping("/mini")
public class HalfController {
    @Autowired
    private HalfRepository halfRepository;
    @PostMapping("/save_half")
    public Object saveHalf(Half half){
        APIResponse res = new APIResponse();
        halfRepository.save(half);
        res.setData(half);
        res.setStatus(1);
        res.setMessage("ok");
        return res;
    }
    @PostMapping("/check_half")
    public Object check(){
        APIResponse res = new APIResponse();
        List<Half> dbHalf = halfRepository.findAll();
        res.setData(dbHalf);
        return res;
    }
}
