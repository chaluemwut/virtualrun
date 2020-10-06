package rmuti.runnerapp.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import rmuti.runnerapp.model.service.TestSaveLatlngRepository;
import rmuti.runnerapp.model.table.TestSaveLatlng;

import java.util.List;

@RestController
@RequestMapping("/test_save_latlng")
public class TestSaveLatlngController {
    private TestSaveLatlngRepository testSaveLatlngRepository;
    public Object save(TestSaveLatlng testSaveLatlng){
        APIResponse res = new APIResponse();
        testSaveLatlngRepository.save(testSaveLatlng);
        res.setData(testSaveLatlng);
        return res;
    }
    public Object load(){
        APIResponse res = new APIResponse();
        List<TestSaveLatlng> dbFun = testSaveLatlngRepository.findAll();
        res.setData(dbFun);
        return res;
    }
}
