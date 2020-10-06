package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "kilometer")
public class Kilometer {
    @Column(name = "t_id")
    private int Tid;
    @Column(name = "user_id")
    private int UserId;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "kilo_id")
    private int KiloId;
    @Column(name = "time")
    private String Time;
}
