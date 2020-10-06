package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;
@Data
@Entity(name = "full")
public class Full {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "fm_id")
    private int FMid;
    @Column(name = "user_id")
    private int UserId;
    @Column(name = "time")
    private String Time;
    @Column(name = "km")
    private String Km;
}
