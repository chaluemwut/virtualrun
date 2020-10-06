package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "user_half")
public class UserHalf {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(name = "user_name_half")
    private String userNameHalf;
    @Column(name = "password_half")
    private String passWordHalf;
}
