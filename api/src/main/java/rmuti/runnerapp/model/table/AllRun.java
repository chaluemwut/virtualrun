package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "all_run")
public class AllRun {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "a_id")
    private int Aid;
    @Column(name = "user_id")
    private int UserId;
    @Column(name = "distance")
    private String Distance;
    @Column(name = "time")
    private String Time;
    @Column(name = "type")
    private String Type;
}
