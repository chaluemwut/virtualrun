package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "user_run")
public class UserRun {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "r_id")
    private int rid;

    @Column(name = "user_id")
    private int userId;

    @Column(name = "a_id")
    private int aid;

    @Column(name = "distancing")
    private String distancing;
}
