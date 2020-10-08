package rmuti.runnerapp.model.table;

import lombok.Data;
import javax.persistence.*;


@Data
@Entity(name = "user_profile")
public class UserProfile {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "user_id")
    private int userId;
    @Column(name = "user_name")
    private String userName;
    @Column(name = "pass_word")
    private String passWord;
}