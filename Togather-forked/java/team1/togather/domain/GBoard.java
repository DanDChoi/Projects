package team1.togather.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GBoard {

  private long gbnum;
  private String gbtitle;
  private long mnum;
  private String mname;
  private String gbcontent;
  private long gblike;
  private long gbview;

  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd (E) HH:mm")
  private Date rdate;

  private long gseq;
  private String gbfname;
  private String gbofname;
  private long gbfsize;
}
