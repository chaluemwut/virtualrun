package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "user_full")
public class UserFull {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(name = "user_name_full")
    private String userNameFull;
    @Column(name = "password_full")
    private String passWordFull;
}
