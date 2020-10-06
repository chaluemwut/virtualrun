package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.UserFunRun;

public interface UserFunRunRepository extends JpaRepository<UserFunRun,Integer> {
    UserFunRun findByUserNameFun(String UserNameFun);
}
