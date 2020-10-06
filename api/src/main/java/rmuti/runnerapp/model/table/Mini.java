package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;
@Data
@Entity(name = "mini")
public class Mini {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "m_id")
    private int Mid;
    @Column(name = "user_id")
    private int UserId;
    @Column(name = "time")
    private String Time;
    @Column(name = "km")
    private String Km;
}
