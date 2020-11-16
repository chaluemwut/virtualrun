package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.UserRun;

public interface UserRunRepository extends JpaRepository<UserRun,Integer> {
}
