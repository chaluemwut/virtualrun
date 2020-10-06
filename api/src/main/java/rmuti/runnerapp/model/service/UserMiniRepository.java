package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.UserMini;

public interface UserMiniRepository extends JpaRepository<UserMini,Integer> {
    UserMini findByUserNameMini(String userNameMini);
}
