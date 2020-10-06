package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.UserFull;

public interface UserFullRepository extends JpaRepository<UserFull,Integer> {
    UserFull findByUserNameFull (String userNameFull);
}
