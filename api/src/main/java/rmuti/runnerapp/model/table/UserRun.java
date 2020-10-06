package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "user_run")
public class UserRun {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "r_id")
    private int Rid;
    @Column(name = "user_id")
    private int UserId;
    @Column(name = "a_id")
    private int Aid;
    @Column(name = "distancing")
    private String Distancing;
}
