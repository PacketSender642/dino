sed -i 's/@VERSION@/0.22/' limine.cfg

nelua dino/main.nelua --cc clang -bo out/kernel.elf
make -C limine

rm -rf out/sysroot
mkdir -p out/sysroot
cp out/kernel.elf \
    bg.bmp limine.cfg limine/limine.sys limine/limine-cd.bin limine/limine-cd-efi.bin out/sysroot/
xorriso -as mkisofs -b limine-cd.bin \
    -no-emul-boot -boot-load-size 4 -boot-info-table \
    --efi-boot limine-cd-efi.bin \
    -efi-boot-part --efi-boot-image --protective-msdos-label \
    out/sysroot -o out/dino.x86_64.iso
./limine/limine-deploy out/dino.x86_64.iso
rm -rf iso_root

sed -i 's/0.22/@VERSION@/' limine.cfg