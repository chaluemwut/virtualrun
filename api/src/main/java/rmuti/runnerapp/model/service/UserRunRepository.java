package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.AllRun;
import rmuti.runnerapp.model.table.UserRun;

import java.util.List;

public interface UserRunRepository extends JpaRepository<UserRun,Integer> {
    List<UserRun> findByUserId(int userId);




    //List<AllRun> findByaid(int aid);
}
