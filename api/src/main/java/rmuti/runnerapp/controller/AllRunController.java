package rmuti.runnerapp.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import rmuti.runnerapp.model.service.AllRunRepository;
import rmuti.runnerapp.model.table.AllRun;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

@RestController
@RequestMapping("/all_run")
public class AllRunController {
    @Autowired
    private AllRunRepository allRunRepository;
    @PostMapping("/save_all")
    public Object saveAll(AllRun allRun){
        APIResponse res = new APIResponse();
        allRunRepository.save(allRun);
        res.setData(allRun);
        return res;
    }
    @PostMapping("/show_fun")
    public Object showFun(){
        APIResponse res = new APIResponse();
        List<AllRun> dbFun = allRunRepository.findAll();
        res.setData(dbFun);
        return res;
    }
    @PostMapping("/test")
    public Object test(@RequestParam String type){
        //APIResponse res = new APIResponse();
        List<AllRun> allRuns = allRunRepository.findAllByType(type);

        return allRuns;
    }
    @GetMapping("/testdata")
    public Object testdata(@RequestParam String type){
        List<AllRun> allRuns = allRunRepository.findAllByType(type);
        return allRuns;
    }
    @PostMapping("/save_save")
    public Object saveRun(AllRun allRun, @RequestParam(value = "fileImg",required = false)MultipartFile fileImg){
        APIResponse res = new APIResponse();
        try{
            if(fileImg != null){
                int count = (int) allRunRepository.count();
                allRun.setAid(count+1);
                allRun.setImg(count+1+".png");
                File fileSave = new File("E://virtualrun//img//"+allRun.getAid()+".png");
                fileImg.transferTo(fileSave);
                allRun = allRunRepository.save(allRun);
                res.setData(allRun);
                res.setMessage("save");
            }
        }catch (Exception err){
            res.setData(1);
            res.setMessage("err : "+err.toString());
        }
        return res;
    }
    @ResponseBody
    @RequestMapping(value = "/img",method = RequestMethod.GET , produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getImg(@RequestParam String imgName) throws Exception{
        try{
            InputStream in = new FileInputStream("E://virtualrun//img//"+imgName);
            return IOUtils.toByteArray(in);
        }catch (Exception err){
            err.printStackTrace();
        }
        return null;
    }
}
