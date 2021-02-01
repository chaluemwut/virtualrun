package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.AllRun;

import java.util.List;

public interface AllRunRepository extends JpaRepository<AllRun,Integer> {

   // AllRun findByType(String Type);

    List<AllRun> findAllByType(String type);


    List<AllRun> findByaid(int aid);

}
