package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.UserHalf;

public interface UserHalfRepository extends JpaRepository<UserHalf,Integer> {
    UserHalf findByUserNameHalf (String userNameHalf);
}
