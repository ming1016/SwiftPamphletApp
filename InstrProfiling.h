//
//  InstrProfiling.h
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/4/2.
//

#ifndef InstrProfiling_h
#define InstrProfiling_h

void __llvm_profile_initialize_file(void);
const char *__llvm_profile_get_filename();
void __llvm_profile_set_filename(const char *);
int __llvm_profile_write_file();
int __llvm_profile_register_write_file_atexit(void);
const char *__llvm_profile_get_path_prefix();

#endif /* InstrProfiling_h */
