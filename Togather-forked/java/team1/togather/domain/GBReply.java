package team1.togather.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GBReply {

  private long gbrseq;
  private long gbnum;
  private String mname;
  private long mnum;
  private String gbrcontent;
  private long gbr_like;

  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd (E) HH:mm")
  private Date rdate;
}
