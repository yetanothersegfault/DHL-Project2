﻿using System;
using System.Collections.Generic;

#nullable disable

namespace Project2.DataModel
{
    public partial class Instructor
    {
        public int InstructorId { get; set; }
        public int CourseId { get; set; }

        public virtual Course Course { get; set; }
        public virtual User InstructorNavigation { get; set; }
    }
}
