package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.FunRun;

public interface FunRunRepository extends JpaRepository<FunRun,Integer> {
}
