/**
 * 知识探索站 — 核心脚本
 * 功能：页面加载进度条、导航高亮、滚动显现、复制按钮、返回顶部
 */

(function() {
  'use strict';

  // ===== 1. 页面加载进度条 =====
  function initProgressBar() {
    const bar = document.createElement('div');
    bar.id = 'progress-bar';
    bar.style.width = '0%';
    document.body.appendChild(bar);

    let width = 0;
    const interval = setInterval(() => {
      if (width < 90) {
        width += Math.random() * 15;
        bar.style.width = Math.min(width, 90) + '%';
      }
    }, 100);

    window.addEventListener('load', () => {
      clearInterval(interval);
      bar.style.width = '100%';
      setTimeout(() => bar.classList.add('is-done'), 300);
      setTimeout(() => bar.remove(), 800);
    });
  }

  // ===== 2. 导航栏滚动效果 =====
  function initNavScroll() {
    const nav = document.querySelector('.site-nav');
    if (!nav) return;

    let ticking = false;
    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(() => {
          nav.classList.toggle('is-scrolled', window.scrollY > 10);
          ticking = false;
        });
        ticking = true;
      }
    });
  }

  // ===== 3. 当前页面导航高亮 =====
  function initNavHighlight() {
    const navLinks = document.querySelectorAll('.site-nav a');
    const currentPath = window.location.pathname;

    navLinks.forEach(link => {
      const href = link.getAttribute('href');
      if (!href) return;
      // 处理相对路径：比较最后一段
      const linkPath = href.replace(/^\.\.\/+/g, '').replace(/^\.\//g, '');
      const pagePath = currentPath.replace(/^\//g, '');
      if (pagePath.endsWith(linkPath) || (pagePath === '' && linkPath === 'index.html')) {
        link.classList.add('active');
      }
    });
  }

  // ===== 4. 滚动显现（Scroll Reveal）=====
  function initScrollReveal() {
    const reveals = document.querySelectorAll('.reveal, .stagger-item');
    if (!reveals.length) return;

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          observer.unobserve(entry.target);
        }
      });
    }, {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    });

    reveals.forEach(el => observer.observe(el));
  }

  // ===== 5. 代码块复制按钮 =====
  function initCopyButtons() {
    const codeBlocks = document.querySelectorAll('pre');

    codeBlocks.forEach(pre => {
      const btn = document.createElement('button');
      btn.className = 'copy-btn';
      btn.textContent = '复制';
      btn.setAttribute('aria-label', '复制代码');

      btn.addEventListener('click', async () => {
        const code = pre.querySelector('code');
        const text = code ? code.textContent : pre.textContent;

        try {
          await navigator.clipboard.writeText(text);
          btn.textContent = '已复制';
          btn.classList.add('is-copied');
          setTimeout(() => {
            btn.textContent = '复制';
            btn.classList.remove('is-copied');
          }, 2000);
        } catch (err) {
          btn.textContent = '失败';
          setTimeout(() => { btn.textContent = '复制'; }, 2000);
        }
      });

      // 包装到 code-block 容器
      const wrapper = document.createElement('div');
      wrapper.className = 'code-block';
      pre.parentNode.insertBefore(wrapper, pre);
      wrapper.appendChild(btn);
      wrapper.appendChild(pre);
    });
  }

  // ===== 6. 返回顶部按钮 =====
  function initBackToTop() {
    const btn = document.createElement('a');
    btn.href = '#';
    btn.className = 'back-to-top';
    btn.innerHTML = '↑';
    btn.setAttribute('aria-label', '返回顶部');
    document.body.appendChild(btn);

    let ticking = false;
    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(() => {
          btn.classList.toggle('is-visible', window.scrollY > 500);
          ticking = false;
        });
        ticking = true;
      }
    });

    btn.addEventListener('click', (e) => {
      e.preventDefault();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // ===== 7. 图片懒加载淡入 =====
  function initLazyImages() {
    const images = document.querySelectorAll('img[data-lazy]');
    if (!images.length) return;

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target;
          img.src = img.dataset.lazy;
          img.onload = () => img.classList.add('is-loaded');
          observer.unobserve(img);
        }
      });
    });

    images.forEach(img => {
      img.classList.add('img-fade');
      observer.observe(img);
    });
  }

  // ===== 8. 卡片 3D 倾斜 =====
  function initCardTilt() {
    const cards = document.querySelectorAll('[data-tilt]');

    cards.forEach(card => {
      const inner = card.querySelector('.card-tilt__inner') || card;

      card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        const rotateX = (y - centerY) / centerY * -5;
        const rotateY = (x - centerX) / centerX * 5;

        inner.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
      });

      card.addEventListener('mouseleave', () => {
        inner.style.transform = 'perspective(1000px) rotateX(0) rotateY(0)';
      });
    });
  }

  // ===== 初始化所有功能 =====
  document.addEventListener('DOMContentLoaded', () => {
    initProgressBar();
    initNavScroll();
    initNavHighlight();
    initScrollReveal();
    initCopyButtons();
    initBackToTop();
    initLazyImages();
    initCardTilt();
  });
})();
