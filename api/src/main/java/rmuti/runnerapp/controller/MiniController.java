package rmuti.runnerapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.MiniRepository;
import rmuti.runnerapp.model.table.Mini;

import java.util.List;

@RestController
@RequestMapping("/mini")
public class MiniController {
    @Autowired
    private MiniRepository miniRepository;
    @PostMapping("/save_mini")
    public Object saveMini(Mini mini){
        APIResponse res = new APIResponse();
        miniRepository.save(mini);
        res.setData(mini);
        res.setStatus(1);
        res.setMessage("ok");
        return res;
    }
    @PostMapping("/check_mini")
    public Object check(){
        APIResponse res = new APIResponse();
        List<Mini> dbMini = miniRepository.findAll();
        res.setData(dbMini);
        return res;
    }
}
