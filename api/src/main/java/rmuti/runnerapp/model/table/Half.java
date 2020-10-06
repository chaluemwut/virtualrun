package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;
@Data
@Entity(name = "half")
public class Half {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "h_id")
    private int Hid;
    @Column(name = "user_id")
    private int UserId;
    @Column(name = "time")
    private String Time;
    @Column(name = "km")
    private String Km;
}
