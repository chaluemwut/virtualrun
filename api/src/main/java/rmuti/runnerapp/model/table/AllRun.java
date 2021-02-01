package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "all_run")
public class AllRun {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "a_id")
    private int aid;
    @Column(name = "distance")
    private String distance;
    @Column(name = "time")
    private String time;
    @Column(name = "type")
    private String type;
}
