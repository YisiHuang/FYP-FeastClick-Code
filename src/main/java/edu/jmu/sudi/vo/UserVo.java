package edu.jmu.sudi.vo;

import edu.jmu.sudi.entity.UserEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserVo extends UserEntity {
    //当前页码
    private Integer page;
    //每页显示数量
    private Integer limit;


}
