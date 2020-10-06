package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "time")
public class Time {
    @Column(name = "t_id")
    private int Tid;
    @Column(name = "user_id")
    private int UserId;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "time_id")
    private int TimeId;
    @Column(name = "time")
    private String Time;
}
