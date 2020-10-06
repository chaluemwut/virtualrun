package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "user_funrun")
public class UserFunRun {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(name = "user_namefun")
    private String userNameFun;
    @Column(name = "password_fun")
    private String passWordFun;
}
