package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "user_mini")
public class UserMini {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(name = "user_name_mini")
    private String userNameMini;
    @Column(name = "password_mini")
    private String passwordMini;
}
